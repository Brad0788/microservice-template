class RolesController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :set_role, only: [:show, :edit, :update, :destroy]
  
    def index
      @roles = Role.all
      render json: @roles
    end
  
    def show
        if @role.nil?
            render json: {
              success: false,
              message: "Role not found"
            }, status: :not_found
        else
            render json: {
                result: {
                  id: @role.id,
                  name: @role.name,
                  description: @role.description,
                  create_date: @role.created_at.strftime("%Y-%m")
                },
                success: true,
                message: "Role encontrado"
              }
            end
    end
  
    def new
      @role = Role.new
    end
  
    def create
      @role = Role.new(role_params)
      if @role.save
        render json: { success: true, message: "Role creado exitosamente" }, status: :created
      else
        render json: { success: false, message: "Ha ocurrido un error al crear el role" }, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @role.update(role_params)
        render json: { success: true, message: "Role editado exitosamente." }, status: :ok
      else
        render json: { success: false, message: "Ha ocurrido un error al editar el role." }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @role.destroy
      render json: { success: true, message: "Role eliminado exitosamente." },status: :no_content
    end
  
    private
  
    def set_role
      @role = Role.find_by(id: params[:id])
    end
  
    def role_params
      params.require(:role).permit(:name, :description, :created_date) # Customize the permitted attributes based on your Role model
    end
  end
  