require 'rails_helper'

RSpec.describe Api::ProjectsController, type: :controller do

  describe "Projects API" do
    let(:project) { create(:project) }

    context "GET #index" do

      before do 
        @project = create(:project)
        get :index, format: :json
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "returns a list" do
        expect(json).to be_an(Array)
      end

      it "returns proper list of projects" do
        expect(json).to include(include('name' => "#{@project.name}"))
        expect(json).to include(include('tasks'))
      end
    end

    context "GET #show" do
      before do        
        get :show, {:id => project.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "returns a specific project" do
        expect(json['name']).to eq(project.name)
      end
    end

    context "POST #create" do
      before do
        puts attributes_for(:project)
        post :create, format: :json, project: attributes_for(:project)
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "returns created project" do
        expect(json).to include('name'=> Project.first.name)
        expect(json).to include('tasks'=> Project.first.tasks)
      end
    end

    context "PUT #update" do
      before do
        @project = create(:project)
        
      end

      it "returns http success" do
        put :update, format: :json, id: @project.id, project: {id: @project.id}
        expect(response).to have_http_status(200)
      end
    end

    context "DELETE #destroy" do
      before do
        delete :destroy, format: :json, id: project.id
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "renders nothing" do
        expect(response.body).to be_blank
      end
    end

  end

end
