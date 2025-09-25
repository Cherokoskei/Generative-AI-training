"""A Country Guessing Game"""

import random;

walker GuessCountry {
    has guess: str;

    can start with `root entry;
    can process_guess with turn entry;
}

node turn {
    has countries: list[str] = ["Kenya", "Uganda", "Tanzania", "Rwanda", "Nigeria", "Ghana"];
    has correct_country: str = random.choice(self.countries);
}

# Will run when in CLI mode (not in cloud)
with entry:__main__ {
    root spawn GuessCountry("Kenya");
    root spawn GuessCountry("Uganda");
    root spawn GuessCountry("Tanzania");
}

impl GuessCountry.start {
    if not [root --> (`?turn)] {
        next = root ++> turn();
    } else {
        next = [root --> (`?turn)];
    }
    visit next;
}

impl GuessCountry.process_guess {
    if [-->] {
        visit [-->];
    } else {
        if self.guess == here.correct_country {
            print(" Congratulations! You guessed correctly.");
            disengage;
        } else {
            print(" Wrong guess. Try again!");
            here ++> turn();
        }
    }
}
