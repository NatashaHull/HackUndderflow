HackUnderflow.Routers.ApplicationRouter = Backbone.Router.extend({
  initialize: function($rootEl) {
    this.$rootEl = $rootEl;
  },

  routes: {
    "": "questionsIndex",
    "questions": "questionsIndex",
    "questions/new": "questionNew",
    "questions/:id": "questionsDetail",
    "users": "usersIndex",
    "users/:id": "usersDetail",
    "about": "about"
  },

  questionsIndex: function() {
    var indexView = new HackUnderflow.Views.QuestionIndex({
      collection: HackUnderflow.questions
    });
    this._swapView(indexView);
  },

  questionsDetail: function(id) {
    var that = this;
    question = HackUnderflow.questions.get(id);
    if(question) {
      that._renderQuestionsDetail(question);
    } else {
      question = new HackUnderflow.Models.Question({ id: id });
      question.fetch({
        success: function() {
          that._renderQuestionsDetail(question);
        }
      });
    }
  },

  questionNew: function() {
    var newView = new HackUnderflow.Views.QuestionNew({
      collection: HackUnderflow.questions,
      model: new HackUnderflow.Models.Question()
    });
    this._swapView(newView);
  },

  usersIndex: function() {
    var indexView = new HackUnderflow.Views.UserIndex({
      collection: HackUnderflow.users
    });

    this._swapView(indexView);
  },

  usersDetail: function(id) {
    var that = this, user;
    user = HackUnderflow.users.get(id);
    if(user.answers.length > 0 || user.questions.length > 0) {
      that._renderUsersDetail(user);
      return;
    }
    user.fetch({
      success: function() {
        that._renderUsersDetail(user);
      }
    });
  },

  about: function() {
    this._swapView(new HackUnderflow.Views.About());
  },

  _swapView: function(view) {
    if(this._prevView) {
      this._prevView.remove();
    }

    this._prevView = view;
    this.$rootEl.html(view.render().$el);
  },

  _renderQuestionsDetail: function(question) {
    var detailView = new HackUnderflow.Views.QuestionDetail({
      model: question
    });
    this._swapView(detailView);
  },

  _renderUsersDetail: function(model) {
    var detailView = new HackUnderflow.Views.UserDetail({
      model: model
    });

    this._swapView(detailView);
    detailView.showFirstItems();
  }
});