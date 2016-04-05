require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Api::TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:ability) { Object.new.extend(CanCan::Ability) }

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return(user)
    ability.can :manage, :all
    allow(controller).to receive(:current_ability).and_return(ability)
  end

  describe "Tasks API" do
    let(:project) { create(:project, user: user) }
    let(:task) { create(:task, project: project) }

    context "POST #create" do

      let(:req) { post :create, {project_id: project.id, format: :json, task: attributes_for(:task)} }

      it "returns http success" do
        req
        expect(response).to have_http_status(200)
      end

      it "creates Task" do
        expect{req}.to change(Task, :count).by(1)
      end

      it "renders :show" do
        req
        expect(response).to render_template(:show)
      end
    end

    context "PUT #update" do
      before do
        put :update, {project_id: project.id, id: task.id, format: :json, task: attributes_for(:task)}
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "locates the requested task" do
        expect(assigns(:task).id).to eq(task.id)
      end

      it "renders :show" do
        expect(response.body).to be_blank
      end
    end

    context "DELETE #destroy" do

      let(:req) { delete :destroy, {project_id: project.id, id: task.id, format: :json, task: attributes_for(:task)} }

      it "returns http success" do
        req
        expect(response).to have_http_status(200)
      end

      it "renders nothing" do
        req
        expect(response.body).to be_blank
      end

      it "deletes the task" do
        project; task
        expect{req}.to change(Task, :count).by(-1)
      end
    end

  end

end
