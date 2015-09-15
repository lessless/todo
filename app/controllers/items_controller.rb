class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy]

  def create
    @item = Item.new(item_params)
    authorize @item

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def destroy
    authorize @item

    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:title, :done, :list_id)
    end
end
