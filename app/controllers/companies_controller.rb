class CompaniesController < ApplicationController
    before_action :set_company, only: [ :update, :destroy]
    before_action :authorize_request , except: [:create]
    before_action :check_type_admin, except: [:update]
    before_action :check_type_user, only: [:update]

    def index
      @companies = Company.all
      json_response(@companies)
    end

    
    def list_filters
      @company = Company.all.order(name: :desc)
      
      filter_id if params[:number_id].present?
      filter_cnpj if params[:number_cnpj].present?
      filter_name if params[:name].present?
      
      json_response(index)
    end
  
    def create
      @company = Company.new(company_params)
  
      if @company.save
        json_response(@company, :created)
      else
        render json: { errors: @company.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      if @company.update(company_params)
        json_response(@company, :ok)
      else
        render :edit
      end
    end
  
    
    def destroy
      @company.destroy
      json_response(@company, 'Company was successfully destroyed.')
    end
  
    private

    def json_response(object, status = :ok)
      render json: object, status: status
    end

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :cnpj, :email)
  end

  # Filters

  def filter_cnpj
    @company = @company.where(cnpj: params[:number_cnpj])
  end

  def filter_name
    @company = @company.where(name: params[:name])
  end

  def filter_id
    @company = @company.where(id: params[:number_id])
  end

end