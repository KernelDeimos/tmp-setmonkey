require 'rails_helper'

RSpec.describe SetsController, type: :controller do
  describe 'union action' do
    it "unifies sets" do
      post :view, params: {commit: 'union', seta: [1,2,3], setb: [4,5,6]}
      expect(assigns(:output)).to match_array(['1','2','3','4','5','6'])
    end
    it "produces a valid set" do
      post :view, params: {commit: 'union', seta: [1,2,3], setb: [2,4,3]}
      expect(assigns(:output)).to match_array(['1','2','3','4'])
    end
  end
  
  describe 'intersection action' do
    it "produces the intersection" do
      post :view, params: {commit: 'intersection', seta: [1,2,3], setb: [2,3,4]}
      expect(assigns(:output)).to match_array(['2','3'])
    end
  end

  describe 'difference action' do
    it "produces the difference" do
      post :view, params: {commit: 'difference', seta: [1,2,3], setb: [2,3,4]}
      expect(assigns(:output)).to match_array(['1','4'])
    end
  end

end
