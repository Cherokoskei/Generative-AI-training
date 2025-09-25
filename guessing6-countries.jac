"""A Country Guessing Game with AI Hints"""

import random;
import from byllm.llm { Model }

# Use Gemini for hint generation
glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

"""Provide a fun hint if guess is incorrect"""
def give_hint(guess: str, correct_country: str) -> str by llm();

walker GuessGame {
    has guess: str;

    can start with `root entry;
    can process_guess with turn entry;
}

node turn {
    has countries: list[str] = ["Kenya", "Uganda", "Tanzania", "Rwanda", "Nigeria", "Ghana"];
    has correct_country: str = random.choice(countries);
}

# Run when in CLI mode
with entry:__main__ {
    root spawn GuessGame("Kenya");
    root spawn GuessGame("Uganda");
}

impl GuessGame.start {
    if not [root --> (`?turn)] {
        next = root ++> turn();
    } else {
        next = [root --> (`?turn)];
    }
    visit next;
}

impl GuessGame.process_guess {
    if [-->] {
        visit [-->];
    } else {
        if self.guess == here.correct_country {
            print(" Correct! The country is " + self.guess);
            disengage;
        } else {
            # Use LLM for smart/fun hints
            let hint = give_hint(self.guess, here.correct_country);
            print(" Wrong guess. Hint: " + hint);
            here ++> turn();
        }
    }
}
