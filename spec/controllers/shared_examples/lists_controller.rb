shared_examples_for 'authorized user' do
  it 'permited to read the list' do
    get :show, {:id => list.to_param}, valid_session
    expect(assigns(:list)).to eq(list)
  end

  it 'permited to destroy the requested list' do
    expect {
      delete :destroy, {:id => list.to_param}, valid_session
    }.to change(List, :count).by(-1)
  end
end
