shared_examples_for 'authorized user' do
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Item' do
        expect {
          post :create, {:item => valid_attributes}, valid_session
        }.to change(Item, :count).by(1)
      end

      it 'assigns a newly created item as @item' do
        post :create, {:item => valid_attributes}, valid_session
        expect(assigns(:item)).to be_a(Item)
        expect(assigns(:item)).to be_persisted
      end

      it 'redirects to the created item' do
        post :create, {:item => valid_attributes}, valid_session
        expect(response).to redirect_to(Item.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved item as @item' do
        post :create, {:item => invalid_attributes}, valid_session
        expect(assigns(:item)).to be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        post :create, {:item => invalid_attributes}, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}, valid_session
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete :destroy, {:id => item.to_param}, valid_session
      expect(response).to redirect_to(items_url)
    end
  end
end
