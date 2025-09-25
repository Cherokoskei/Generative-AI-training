import random;

class Game {
    has attempts: int;
    has won: bool;

    def init(self: Game, attempts: int = 5) {
        self.attempts = attempts;
        self.won = false;
    }

    def play(self: Game) {
        raise AssertionError("Subclasses must implement this method.");
    }
}


class GuessTheCountryGame(Game) {
    has correct_country: str;
    has countries: list[str];

    def init(self: GuessTheCountryGame, attempts: int = 5) {
        super.init(attempts);
        self.countries = ["Kenya", "Uganda", "Tanzania", "Rwanda", "Nigeria", "Ghana"];
        self.correct_country = random.choice(self.countries);
    }

    def play(self: GuessTheCountryGame) {
        std.out(" Guess the country from this list: " + str(self.countries));

        while self.attempts > 0 {
            std.out("Enter your guess: ");
            let guess: str = std.input();

            self.process_guess(guess);

            if self.won {
                break;
            }
        }

        if not self.won {
            std.out(" Sorry, the correct country was: " + self.correct_country);
        }
    }

    def process_guess(self: GuessTheCountryGame, guess: str) {
        if guess == self.correct_country {
            std.out(" Congratulations! You guessed correctly.");
            self.won = true;
            return;
        }

        # Alphabetical hint
        if guess < self.correct_country {
            std.out("Hint: The correct country comes AFTER " + guess + " alphabetically.");
        } else {
            std.out("Hint: The correct country comes BEFORE " + guess + " alphabetically.");
        }

        self.attempts -= 1;
        std.out("You have " + str(self.attempts) + " attempts left.");
    }
}


with entry {
    let game = GuessTheCountryGame();
    game.play();
}
