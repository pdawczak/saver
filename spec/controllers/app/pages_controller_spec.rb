require 'rails_helper'

RSpec.describe App::PagesController, :type => :controller do

  describe "GET index" do

    context "when user is not logged in" do
      it "return http found" do
        get :index
        expect(response).to have_http_status(:found)
      end
    end

    context "when user logged in" do
      let(:current_user) { create(:user) }
      let(:another_user) { create(:user) }

      before do
        @page         = current_user.pages.create(attributes_for(:page))
        @another_user = another_user.pages.create(attributes_for(:page))
        sign_in(:user, current_user)
      end

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns new Page model" do
        get :index
        expect(assigns(:page)).not_to be_persisted
      end

      it "assigns Pages for current_user only" do
        get :index
        expect(assigns(:pages)).to eq [@page]
        expect(assigns(:pages)).not_to include(@another_page)
      end
    end

  end

  describe "POST create" do
    let(:user) { create(:user) }

    before do
      sign_in(:user, user)
    end

    context "with valid attributes" do
      let(:valid_attrs) do
        attributes_for(:page, url: "http://google.com",
                              title: "The Google",
                              description: "Best search!")
      end

      it "saves the Page" do
        expect {
          post :create, page: valid_attrs
        }.to change { Page.count }.by 1
      end

      it "redirects to index" do
        post :create, page: valid_attrs
        expect(response).to redirect_to app_path
      end

      it "sets the flash message" do
        post :create, page: valid_attrs
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid attributes" do
      let(:invalid_attrs) do
        attributes_for(:page, url: nil)
      end

      before do
        @sample_page = user.pages.create(attributes_for(:page))
      end

      it "doesn't save the Page" do
        expect {
          post :create, page: invalid_attrs
        }.not_to change { Page.count }
      end

      it "should render index" do
        post :create, page: invalid_attrs
        expect(response).to render_template(:index)
      end

      it "assigns current_user pages" do
        post :create, page: invalid_attrs
        expect(assigns(:pages)).to eq [@sample_page]
      end
    end
  end

end
