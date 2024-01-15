class CertificatesController < ApplicationController
    before_action :set_certificate, only: [:show, :update, :destroy]
    before_action :authorize_request
    before_action :check_type_admin, except: [:list_filters_expired, :list_filters]
    before_action :check_type_user, only: [:list_filters_expired, :list_filters]

    def index
      @certificates = Certificate.all
      json_response(@certificates)
    end

    def show
      @certificate = Certificate.find(params[:id])
      render json: @certificate, status: :ok
    end

    def list_filters_expired
      @certificate = Certificate.all.order(validity: :desc)
      filter_validity_cnpj if params[:number_cnpj].present?
      filter_validity_id if params[:number_id].present?

      json_response(@certificate)
    end

    def list_filters
      @certificate = Certificate.all.order(validity: :desc)
      filter_cnpj if params[:number_cnpj].present? 
      filter_company if params[:company].present?
      
      json_response(@certificate)
    end
  
    def create
      @certificate = Certificate.new(certificate_params)
      @certificate.company = Company.find(params[:certificate][:company_id])
    
      if @certificate.save
        json_response(@certificate, :created)
      else
        puts @certificate.errors.full_messages
        render json: @certificate.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @certificate.update(certificate_params)
        json_response(@certificate)
      else
        json_response(@certificate.errors, :unprocessable_entity)
      end
    end
  
    def destroy
      @certificate.destroy
    end
  
    private
    
    def json_response(object, status = :ok)
      render json: object, status: status
    end

      def set_certificate
        @certificate = Certificate.find(params[:id])
      end
      
      def certificate_params
        params.require(:certificate).permit( :title, :company_id, :validity, :value, :cnpj,  :description)
      end

      #filters
      def filter_validity_cnpj
        @certificate = @certificate.where('cnpj = ? AND validity < ?', params[:number_cnpj], Time.now)
      end

      def filter_validity_id
        @certificate = @certificate.where('company_id = ? AND validity < ?', params[:number_id], Time.now)
      end

      def filter_cnpj
        @certificate = @certificate.where(cnpj: params[:number_cnpj])
      end

      def filter_company
        @certificate = @certificate.where(company: params[:company])
      end

end
