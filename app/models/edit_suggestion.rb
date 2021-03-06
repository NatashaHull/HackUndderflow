class EditSuggestion < ActiveRecord::Base
  attr_accessible :body

  validates_presence_of :body, :editable_id, :editable_type, :user_id

  belongs_to :editable, :polymorphic => true
  belongs_to :user

  def accept_edit
    self.editable.body = self.body
    self.accepted = true
    ActiveRecord::Base.transaction do
      self.user.add_points(2)
      self.editable.save!
      self.save!
    end
  end

  def question
    if self.editable_type == "Question"
      self.editable
    else
      self.editable.question
    end
  end

  def question_title
    self.question.title
  end

  #Adding necessary elements to JSON
  def as_json(options={})
    options[:methods] ||= []
    options[:methods] << :question_title
    super(options)
  end
end
