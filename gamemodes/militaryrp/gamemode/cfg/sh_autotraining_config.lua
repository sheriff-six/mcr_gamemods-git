if !frontline.config.enable_autotraining then return end -- Don't touch!

frontline.config.autotraining_model = "models/Kleiner.mdl" -- Path to model for autotraining entity
frontline.config.default_class_after_autotraining = "Shooter" -- Class issued after passing the test

frontline.config.start_text = { -- Text before starting the test
  "This is a bot for your quick learning without the help of an instructor",
  "",
  "Are you sure you want to take the test?",
}

frontline.config.questions = { -- Test questions text
  {
    task_text = { -- Question text
      "You are human?",
    },
    task_answers = { -- Answer options. FALSE is the wrong answer and TRUE is the right answer.
      {"No", false},
      {"I am a dog", false},
      {"Sure!", true},
    },
  },
  {
    task_text = { -- Question text
      "Do you like this gamemode?",
      "Do you like this gamemode?",
      "Do you like this gamemode?",
    },
    task_answers = { -- Answer options. FALSE is the wrong answer and TRUE is the right answer.
      {"Trash!", false},
      {"I am a cat", false},
      {"Yeah!", true},
    },
  },
}
