require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Api::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:ability) { Object.new.extend(CanCan::Ability) }

  before do
    sign_in user
    ability.can :manage, :all
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:current_ability).and_return(ability)
  end

  describe "Tasks API" do
    let(:project) { create(:project, user: user) }
    let(:task) { create(:task, project: project) }
    let(:comment) { create(:comment, task: task) }

    context "POST #create" do

      let(:req) { post :create, {task_id: task.id, format: :json, comment: attributes_for(:comment)} }

      it "returns http success" do
        req
        expect(response).to have_http_status(200)
      end

      it "creates Comment" do
        expect{req}.to change(Comment, :count).by(1)
      end

      it "renders :show" do
        req
        expect(response).to render_template(:show)
      end
    end

    context "PUT #update" do
      before do
        put :update, {task_id: task.id, id: comment.id, format: :json, comment: attributes_for(:comment)}
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end

      it "locates the requested comment" do
        expect(assigns(:comment).id).to eq(comment.id)
      end

      it "renders :show" do
        expect(response.body).to be_blank
      end
    end

    context "DELETE #destroy" do

      let(:req) { delete :destroy, {task_id: task.id, id: comment.id, format: :json, comment: attributes_for(:comment)} }

      it "returns http success" do
        req
        expect(response).to have_http_status(200)
      end

      it "renders nothing" do
        req
        expect(response.body).to be_blank
      end

      it "deletes the comment" do
        task; comment
        expect{req}.to change(Comment, :count).by(-1)
      end
    end

  end

end
