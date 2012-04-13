require 'spec_helper'

describe ServersController do
  before(:each) do
    @server = Factory(:server)
  end

  after(:each) do
    @server.destroy
  end

  describe "GET index" do
    it "assigns all servers as @servers" do
      get :index
      assigns(:servers).should eq([@server])
    end
  end

  describe "GET show" do
    it "assigns the requested server as @server" do
      get :show, {:id => @server.to_param}
      assigns(:server).should eq(@server)
    end
  end

  describe "GET new" do
    it "assigns a new server as @server" do
      get :new
      assigns(:server).should be_a_new(Server)
    end
  end

  describe "GET edit" do
    it "assigns the requested server as @server" do
      get :edit, {:id => @server.to_param}
      assigns(:server).should eq(@server)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Server" do
        expect {
          post :create, {:server => @server.attributes}
        }.to change(Server, :count).by(1)
      end

      it "assigns a newly created server as @server" do
        post :create, {:server => @server.attributes}
        assigns(:server).should be_a(Server)
        assigns(:server).should be_persisted
      end

      it "redirects to the created server" do
        post :create, {:server => @server.attributes}
        response.should redirect_to(Server.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved server as @server" do
        Server.any_instance.stub(:save).and_return(false)
        post :create, {:server => {}}
        assigns(:server).should be_a_new(Server)
      end

      it "re-renders the 'new' template" do
        Server.any_instance.stub(:save).and_return(false)
        post :create, {:server => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested server" do
        Server.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => @server.to_param, :server => {'these' => 'params'}}
      end

      it "assigns the requested server as @server" do
        put :update, {:id => @server.to_param, :server => @server.attributes}
        assigns(:server).should eq(@server)
      end

      it "redirects to the server" do
        put :update, {:id => @server.to_param, :server => { :username => :foobar }}
        response.should redirect_to(@server)
      end
    end

    describe "with invalid params" do
      it "assigns the server as @server" do
        Server.any_instance.stub(:save).and_return(false)
        put :update, {:id => @server.to_param, :server => {}}
        assigns(:server).should eq(@server)
      end

      it "re-renders the 'edit' template" do
        Server.any_instance.stub(:save).and_return(false)
        put :update, {:id => @server.to_param, :server => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested server" do
      expect {
        delete :destroy, {:id => @server.to_param}
      }.to change(Server, :count).by(-1)
    end

    it "redirects to the servers list" do
      delete :destroy, {:id => @server.to_param}
      response.should redirect_to(servers_url)
    end
  end

end
