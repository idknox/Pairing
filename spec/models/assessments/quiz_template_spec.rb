require 'spec_helper'

module Assessments
  describe QuizTemplate do

    let(:quiz_template) { QuizTemplate.create!(name: 'Foo', question_text: 'bar') }

    it "cannot be deleted" do
      expect { quiz_template.destroy }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end

    it "cannot be updated" do
      expect { quiz_template.update_attributes!(name: 'Bar') }.to raise_error(ActiveRecord::ReadOnlyRecord)
    end

  end
end