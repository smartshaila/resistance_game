class RoleRelationshipsController < ApplicationController
  before_action :set_role_relationship, only: [:show, :edit, :update, :destroy]

  # GET /role_relationships
  # GET /role_relationships.json
  def index
    @role_relationships = RoleRelationship.all
  end

  # GET /role_relationships/1
  # GET /role_relationships/1.json
  def show
  end

  # GET /role_relationships/new
  def new
    @role_relationship = RoleRelationship.new
  end

  # GET /role_relationships/1/edit
  def edit
  end

  # POST /role_relationships
  # POST /role_relationships.json
  def create
    @role_relationship = RoleRelationship.new(role_relationship_params)

    respond_to do |format|
      if @role_relationship.save
        format.html { redirect_to @role_relationship, notice: 'Role relationship was successfully created.' }
        format.json { render :show, status: :created, location: @role_relationship }
      else
        format.html { render :new }
        format.json { render json: @role_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role_relationships/1
  # PATCH/PUT /role_relationships/1.json
  def update
    respond_to do |format|
      if @role_relationship.update(role_relationship_params)
        format.html { redirect_to @role_relationship, notice: 'Role relationship was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_relationship }
      else
        format.html { render :edit }
        format.json { render json: @role_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_relationships/1
  # DELETE /role_relationships/1.json
  def destroy
    @role_relationship.destroy
    respond_to do |format|
      format.html { redirect_to role_relationships_url, notice: 'Role relationship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_relationship
      @role_relationship = RoleRelationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_relationship_params
      params.require(:role_relationship).permit(:role_id, :revealed_role_id, :revealed_allegiance)
    end
end
