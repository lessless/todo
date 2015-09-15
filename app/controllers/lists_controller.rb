class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]

  def show
    authorize @list
  end

  def destroy
    authorize @list
    @list.destroy
    redirect_to lists_url, notice: 'List was successfully destroyed.'
  end

private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
end
