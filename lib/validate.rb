def valid?(questions, answers)
  response_hash = {}
  complete_if_selected = false
  p answers
  questions.each.with_index do |question, idx| 
    if (answers == nil || !answers.has_key?(:"q#{idx}")) && !complete_if_selected
      response_hash[:"q#{idx}"] = 'was not answered'  
    else 
      selection = answers[:"q#{idx}"]
      next if selection == nil 
      if complete_if_selected 
        response_hash[:"q#{idx}"] = 'was answered even though a previous response indicated that the questions were complete'
      elsif !question[:options][selection]
        response_hash[:"q#{idx}"] = 'has an answer that is not on the list of valid answers'
      elsif question[:options][selection].has_key?(:complete_if_selected)
        complete_if_selected = true
      end
    end
  end

  response_hash.length == 0 ? true : response_hash
end

questions = [
  { text: 'q1', options: [{ text: 'an option'}, { text: 'the right option', complete_if_selected: true }] },
  { text: 'q2', options: [{ text: 'an option' }, { text: 'another option' }] }
]
answers = {q0: 1}
