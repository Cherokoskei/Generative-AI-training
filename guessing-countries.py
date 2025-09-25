import random

class Game:
    def __init__(self, attempts):
        self.attempts = attempts

    def play(self):
        raise NotImplementedError("Subclasses must implement this method.")


class GuessTheCountryGame(Game):
    def __init__(self, attempts=5):
        super().__init__(attempts)
        # Dictionary with countries and their continents
        self.countries = {
            "Kenya": "Africa",
            "Brazil": "South America",
            "Japan": "Asia",
            "Canada": "North America",
            "Germany": "Europe",
            "Australia": "Oceania"
        }
        self.correct_country = random.choice(list(self.countries.keys()))

    def play(self):
        print("🌍 Guess the country! Choices are:", ", ".join(self.countries.keys()))
        while self.attempts > 0:
            guess = input("Enter your guess: ").strip().title()
            if self.process_guess(guess):
                print("🎉 Congratulations! You guessed the correct country.")
                return
            else:
                self.attempts -= 1
                if self.attempts > 0:
                    print(f"❌ Wrong guess. You have {self.attempts} attempts left.")
                    self.give_hint()

        print(f"😢 Sorry, you didn't guess it. The correct country was {self.correct_country}.")

    def process_guess(self, guess):
        return guess == self.correct_country

    def give_hint(self):
        # Provide a random hint
        hint_type = random.choice(["continent", "first_letter"])
        if hint_type == "continent":
            print(f"💡 Hint: The country is in {self.countries[self.correct_country]}.")
        else:
            print(f"💡 Hint: The country starts with '{self.correct_country[0]}'.")
            

# Run the game
game = GuessTheCountryGame()
game.play()
