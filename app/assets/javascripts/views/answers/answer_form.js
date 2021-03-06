HackUnderflow.Views.AnswersForm = Backbone.View.extend({
  template: JST["answers/_form"],

  events:{
    "submit form": "addAnswer"
  },

  render: function() {
    renderedContent = this.template({
      answer: this.model,
      current_user: null
    });

    this.$el.html(renderedContent);
    return this;
  },

  addAnswer: function(event) {
    var that = this;
    event.preventDefault();
    var form = $(event.currentTarget);
    that.model.set("body", form.children("textarea").val());
    that.model.save(null, {
      success: function() {
        that.collection.add(that.model);
      },
      error: function(model, errors) {
        var valErrors = errors.responseJSON;
        var $errors = $("<ul>");
        valErrors.forEach(function(error) {
          $errors.prepend("<li>" + error + "</li>");
        });
        that.$el.prepend($errors);
      }
    });
  }
});