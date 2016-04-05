require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Api::ProjectsController, type: :controller do
  render_views
  let(:user) { create(:user) }

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(@controller).to receive(:current_ability).and_return(@ability)
    @ability.can :manage, :all
  end

  describe "Projects API" do
    let(:project) { create(:project, user_id: user.id) }

    context "GET #index" do

      before do 
        project
        get :index, format: :json
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "renders :index template" do
        expect(response).to render_template(:index)
      end

      it "assigns @projects" do
        expect(assigns(:projects)).to eq([project])
      end
    end

    context "GET #show" do
      before do        
        get :show, {:id => project.id, format: :json}
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "renders :show template" do
        expect(response).to render_template(:show)
      end

      it "assigns @project" do
        expect(assigns(:project)).to eq(project)
      end
    end

    context "POST #create" do

      let(:req) { post :create, {format: :json, project: attributes_for(:project)} }

      it "returns http success" do
        req
        expect(response).to have_http_status(200)
      end

      it "create Project" do
        expect{req}.to change(Project, :count).by(1)
      end

      it "creates Project for current_user" do    
        expect{req}.to change(user.projects, :count).by(1)
      end

      it "renders :show" do
        req
        expect(response).to render_template(:show)
      end
    end

    context "PUT #update" do
      before do
        project
        put :update, format: :json, id: project, project: attributes_for(:project)
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "locates the requested project" do
        expect(assigns(:project).id).to eq(project.id)
      end

      it "renders :show" do
        expect(response).to render_template(:show)
      end
    end

    context "DELETE #destroy" do

      before { project }

      let(:req) { delete :destroy, format: :json, id: project.id }

      it "returns http success" do
        req
        expect(response).to have_http_status(200)
      end

      it "renders nothing" do
        req
        expect(response.body).to be_blank
      end

      it "deletes the project" do
        expect{req}.to change(Project, :count).by(-1)
      end
    end

  end

end
