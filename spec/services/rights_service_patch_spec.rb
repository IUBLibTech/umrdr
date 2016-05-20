require 'rails_helper'

describe RightsService do
  before do
    # Configure QA to use fixtures
    qa_fixtures ={local_path: File.expand_path('../../fixtures/authorities', __FILE__)}
    stub_const("Qa::Authorities::LocalSubauthority::AUTHORITIES_CONFIG", qa_fixtures)
  end

  describe "#select_options" do
    it "returns active terms" do
      expect(RightsService.select_options).to include(["First Active Term", "demo_id_01"], ["Second Active Term", "demo_id_02"])
    end

    it "does not return inactive terms" do
      expect(RightsService.select_options).not_to include(["Third is an Inactive Term", "demo_id_03"], ["Fourth is an Inactive Term", "demo_id_04"])
    end
  end

  describe "#label" do
    it "resolves for ids of active terms" do
      expect(RightsService.label('demo_id_01')).to eq("First Active Term")
    end

    it "resolves for ids of inactive terms" do
      expect(RightsService.label('demo_id_03')).to eq("Third is an Inactive Term")
    end
  end
end
