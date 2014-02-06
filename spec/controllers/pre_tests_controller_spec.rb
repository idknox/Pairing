require 'spec_helper'

describe PreTestsController do
  describe '#answer' do
    it 'redirects to the index page if there is no next question' do
      user = sign_in

      PreTest.create!(user: user)
      question = PreTestQuestion.create!(text: 'some question')

      post :update_answer, question_id: question.to_param, pre_test_answer: { answer_text: 'Foo' }

      expect(response).to redirect_to(pre_test_path)
    end
  end
end