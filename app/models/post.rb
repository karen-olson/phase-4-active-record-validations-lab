class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: {in: ["Fiction", "Non-Fiction"]}
    validate :clickbait?

    private 

    # i indicates case insensitive mode
    # \d indicates any digit
    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i, 
        /Guess/
    ]

    # With RegEx
    def clickbait? 
        if CLICKBAIT_PATTERNS.none? {|pattern| pattern.match title}
            errors.add(:title, "must be clickbait")
        end
    end

    # Without RegEx
    # def clickbait?
    #     keywords = ["Won't Believe", "Secret", "Top", "Guess"]
    #     if title 
    #         isValid = keywords.any?{|string| title.downcase.include?(string.downcase)}
    #     else 
    #         isValid = false 
    #     end 

    #     unless isValid
    #         errors.add(:title, "not clickbait-y enough")
    #     end
    # end
end
