require 'spec_helper'

describe TestDescriptionsController do
  before(:each) do
    @test_description = Factory(:test_description)
  end
  
  after(:each) do
    @test_description.destroy
  end

  describe "GET index" do
    it "assigns all test_descriptions as @test_descriptions" do
      get :index
      assigns(:test_descriptions).should eq([@test_description])
    end
  end

  describe "GET show" do
    it "assigns the requested test_description as @test_description" do
      get :show, {:id => @test_description.to_param}
      assigns(:test_description).should eq(@test_description)
    end
  end

  describe "GET new" do
    it "assigns a new test_description as @test_description" do
      get :new
      assigns(:test_description).should be_a_new(TestDescription)
    end
  end

  describe "GET edit" do
    it "assigns the requested test_description as @test_description" do
      get :edit, {:id => @test_description.to_param}
      assigns(:test_description).should eq(@test_description)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TestDescription" do
        expect {
          post :create, {:test_description => @test_description.attributes}
        }.to change(TestDescription, :count).by(1)
      end

      it "assigns a newly created test_description as @test_description" do
        post :create, {:test_description => @test_description.attributes}
        assigns(:test_description).should be_a(TestDescription)
        assigns(:test_description).should be_persisted
      end

      it "redirects to the created test_description" do
        post :create, {:test_description => @test_description.attributes}
        response.should redirect_to(TestDescription.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved test_description as @test_description" do
        TestDescription.any_instance.stub(:save).and_return(false)
        post :create, {:test_description => {}}
        assigns(:test_description).should be_a_new(TestDescription)
      end

      it "re-renders the 'new' template" do
        TestDescription.any_instance.stub(:save).and_return(false)
        post :create, {:test_description => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested test_description" do
        TestDescription.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => @test_description.to_param, :test_description => {'these' => 'params'}}
      end

      it "assigns the requested test_description as @test_description" do
        test_description = TestDescription.create! @test_description.attributes
        put :update, {:id => @test_description.to_param, :test_description => {:description => "foobar"}}
        assigns(:test_description).should eq(@test_description)
      end

      it "redirects to the test_description" do
        put :update, {:id => @test_description.to_param, :test_description => {:description => "foobar"}}
        response.should redirect_to(@test_description)
      end
    end

    describe "with invalid params" do
      it "assigns the test_description as @test_description" do
        TestDescription.any_instance.stub(:save).and_return(false)
        put :update, {:id => @test_description.to_param, :test_description => {}}
        assigns(:test_description).should eq(@test_description)
      end

      it "re-renders the 'edit' template" do
        TestDescription.any_instance.stub(:save).and_return(false)
        put :update, {:id => @test_description.to_param, :test_description => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested test_description" do
      expect {
        delete :destroy, {:id => @test_description.to_param}
      }.to change(TestDescription, :count).by(-1)
    end

    it "redirects to the test_descriptions list" do
      delete :destroy, {:id => @test_description.to_param}
      response.should redirect_to(test_descriptions_url)
    end
  end

end
