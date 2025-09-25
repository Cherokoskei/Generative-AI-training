import random;

obj Game {
    has attempts: int = 5;
    has won: bool = false;

     //def play;   
}

obj GuessTheCountryGame(Game) {
    has countries: list[str] = ["Kenya", "Uganda", "Tanzania", "Rwanda", "Nigeria", "Ghana"];
    has correct_country: str;

    def init {
        self.correct_country = random.choice(self.countries);
    }

    override def play {
        std.out("🌍 Guess the country from this list: " + str(self.countries));

        while self.attempts > 0 {
            std.out("Enter your guess: ");
            let guess = std.input();

            self.process_guess(guess);

            if self.won {
                break;
            }
        }

        if not self.won {
            std.out("❌ Sorry, the correct country was: " + self.correct_country);
        }
    }

    def process_guess(guess: str) {
        if guess == self.correct_country {
            std.out("🎉 Congratulations! You guessed correctly.");
            self.won = true;
        } else {
            std.out("❌ Wrong guess! Try again.");
            self.attempts = self.attempts - 1;
            std.out("You have " + str(self.attempts) + " attempts left.");
        }
    }
}

with entry {
    let game = GuessTheCountryGame();
    game.play();
}
