# /
class Score
  @path_to_store_file = File.join(__dir__, '..', 'store', 'db_scores.yml')

  class << self
     def create(user_name:, status:, used_attempts:, used_hints:)
       score_arr = YAML.load_file(@path_to_store_file) || []
       new_score = {
         user_name: user_name,
         status: status,
         used_hints: used_hints,
         used_attempts: used_attempts
       }
       score_arr << new_score
       File.open(@path_to_store_file, 'w') { |f| f.puts score_arr.to_yaml }
       new_score
     end

     def all
       YAML.load_file(@path_to_store_file) || []
     end
   end
end
