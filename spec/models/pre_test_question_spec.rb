require 'spec_helper'

describe PreTestQuestion do

  describe '.question_after' do

    it 'returns the question with the next highest id or nil' do
      question1 = PreTestQuestion.create!(text: 'foo')
      question2 = PreTestQuestion.create!(text: 'bar')
      question3 = PreTestQuestion.create!(text: 'baz')

      expect(PreTestQuestion.question_after(question1)).to eq(question2)
      expect(PreTestQuestion.question_after(question2)).to eq(question3)
      expect(PreTestQuestion.question_after(question3)).to be_nil

      question2.destroy

      expect(PreTestQuestion.question_after(question1)).to eq(question3)
    end

  end

end