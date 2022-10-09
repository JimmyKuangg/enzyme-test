require 'rspec'
require 'validate'

describe '#validate' do 
  context "when there are no answers" do
    it "returns 'was not answered' for questions with no answers" do
      questions = [{ text: 'q1', options: valid_options }]
      answers = {}
      expect(valid?(questions, answers)).to eq({q0: 'was not answered'})
    end
  end

  context "when answers is nil" do
    it "returns 'was not answered' for all questions" do
      questions = [
        { text: 'q1', options: valid_options }, 
        { text: 'q2', options: valid_options }
      ]
      answers = nil
      expect(valid?(questions, answers)).to eq({q0: 'was not answered', q1: 'was not answered'})
    end
  end

  context "when appropriate questions are answered" do
    it "returns true" do
      questions = [{ text: 'q1', options: valid_options }]
      answers = {q0: 1}
      expect(valid?(questions, answers)).to eq(true);
    end
  end

  context "when a question is not answered" do
    it "returns 'was not answered' for each question not answered" do
      questions = [
        { text: 'q1', options: valid_options }, 
        { text: 'q2', options: valid_options }
      ]
      answers = {q0: 1}
      expect(valid?(questions, answers)).to eq({q1: 'was not answered'})
    end
  end

  context "when an answer is not from one of the given options" do
    it "returns 'has an answer that is not on the list of valid answers' for each question invalid" do
       questions = [
        { text: 'q1', options: valid_options }, 
        { text: 'q2', options: valid_options }
      ]
      answers = {q0: 1, q1: 3} 
      expect(valid?(questions, answers)).to eq({
        q1: 'has an answer that is not on the list of valid answers'
      })
    end
  end

  context "when a question has an option marked as complete_if_selected is selected" do
    it "returns true if other questions are not answered" do
      questions = [
        { text: 'q1', options: [{ text: 'an option'}, { text: 'the right option', complete_if_selected: true }] },
        { text: 'q2', options: valid_options }
      ]
      answers = {q0: 1}
      expect(valid?(questions, answers)).to eq(true)
    end
  end

  context "when a question is answered after a choice of complete_if_selected is selected" do
    it "returns 'was answered even though a previous response indicated that the questions were complete' for each question answered" do
      questions = [
        { text: 'q1', options: [{ text: 'an option'}, { text: 'the right option', complete_if_selected: true }] },
        { text: 'q2', options: valid_options }
      ]
      answers = {q0: 1, q1: 1}
      expect(valid?(questions, answers)).to eq({
        q1: 'was answered even though a previous response indicated that the questions were complete'
      })
      end
    end

  def valid_options
    [{ text: 'an option' }, { text: 'another option' }]
  end
end

