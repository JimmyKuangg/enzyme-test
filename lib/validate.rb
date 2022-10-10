def valid?(questions, answers)
  response_hash = {}
  complete_if_selected = false

  questions.each.with_index do |question, idx|
    idx_symbol = :"q#{idx}"
    selection = answers == nil || answers[idx_symbol] == nil ? nil : answers[idx_symbol]
    if (selection == nil) && !complete_if_selected
      response_hash[idx_symbol] = 'was not answered'
    elsif !(selection == nil)
      if complete_if_selected 
        response_hash[idx_symbol] = 'was answered even though a previous response indicated that the questions were complete'
      elsif !question[:options][selection]
        response_hash[idx_symbol] = 'has an answer that is not on the list of valid answers'
      elsif question[:options][selection].has_key?(:complete_if_selected)
        complete_if_selected = true
      end
    end
  end

  response_hash.length == 0 ? true : response_hash
end

