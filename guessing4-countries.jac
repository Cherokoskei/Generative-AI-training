"""A Country Guessing Game"""

import random;

walker GuessCountryGame {
    has countries: list[str] = ["Kenya", "Uganda", "Tanzania", "Rwanda", "Nigeria", "Ghana"];
    has correct_country: str = random.choice(self.countries);

    can start_game with `root entry;
    def process_guess(guess: str);
}

node turn {
    can check with GuessCountryGame entry;
}

# Run the game
with entry {
    GuessCountryGame() spawn root;
}

impl turn.check {
    guess = input("Guess the country: ");
    visitor.process_guess(guess);
    visit [-->];
}

impl GuessCountryGame.start_game {
    end: `root | turn = here;
    for i = 0 to i < 5 by i += 1 {
        end ++> (end := turn());
    }
    visit [-->];
}

impl GuessCountryGame.process_guess(guess: str) {
    if guess == self.correct_country {
        print(" Congratulations! You guessed correctly.");
        disengage;
    } else {
        #  alphabetical hint
        if guess < self.correct_country {
            print("Hint: The correct country comes AFTER " + guess + " alphabetically.");
        } else {
            print("Hint: The correct country comes BEFORE " + guess + " alphabetically.");
        }
    }
}
