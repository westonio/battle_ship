# Battle Ship

## Project Overview 
Welcome to our Battleship game implemented in Ruby! This project is a collaborative effort that demonstrates our proficiency in test-driven development (TDD) using RSpec. The game can be played entirely within the terminal and allows players to engage in the classic Battleship strategy game, where they strategically place ships on a board and attempt to sink their opponent's ships.

### Languages, Frameworks, and Tools used:
- **Built with:** Ruby
- **Tested with:** RSpec (and Pry for spiking out solutions)
- **Tools / Workflow:** Git, GitHub, GitHub Projects, Driver-Navigator Pair Programming
---
### Features
- **Dynamic Board Size:** Our Battleship game offers the flexibility to choose the dimensions of the game board. Players can specify the number of rows and columns they want (up to 10), tailoring the experience to their preference.
- **Custom Ship Configuration:** Players can also set the number, size, and name of the ships that will be placed on the board. This feature allows for a customizable game experience, ensuring excitement for players of all skill levels.
- **Computer Opponent:** Users can play against a computer opponent with dynamic and random ship placement to ensure the user can play the game again and again.
- **User Feedback**: The user is given visual feedback on the gameboard and dialogue to emulate the real game.
- **TDD Approach:** The game's development followed a test-driven approach using RSpec. Our codebase is thoroughly tested to ensure robustness, reliability, and maintainability.

### Project Challenges:
- Working collaboratively using the driver-navigator style required effective communication and synchronization among team members. Coordinating coding sessions, ensuring consistent coding style, and resolving merge conflicts in the version control system were challenges we had to overcome.
- Designing a game that allowed players to dynamically set the board dimensions and customize the ship configuration presented challenges in terms of validation and ensuring the game's rules were upheld. We needed to handle edge cases, such as when the board size was too small for the specified ship sizes or when the total ship area exceeded the board area.
- Developing a Battleship game with multiple layers of logic, including board setup, ship placement, and hit detection, posed a challenge in terms of writing comprehensive unit tests. We had to ensure that our test suite covered all possible scenarios, interactions, and edge cases to provide confidence in the game's functionality. For example, we took into consideration edge cases for user input case sensitivity, accidental whitespace, and when users may type invalid coordinates.

### Accomplishments:
- Through the development process, we gained a deep appreciation for test-driven development. Writing tests before implementing functionality not only ensured the accuracy of our code but also guided our design decisions. It helped us catch bugs early and refactor with confidence.
- Collaborating in a group project taught us valuable skills in communication, especially when switching roles between driver and navigator. Sharing ideas, explaining design choices, and reviewing each other's code fostered a productive and learning-oriented environment.
- Building a game with customizable board dimensions and ship configurations taught us about designing for flexibility and user-friendliness. We learned to balance user input validation, error handling, and maintaining a coherent gaming experience that adhered to the rules of Battleship.
- Creating Battleship as a collaborative group project allowed us to master the art of working together effectively using Git version control and using GitHub projects. We successfully managed to maintain a shared codebase, facilitate code reviews, and address merge conflicts efficiently. This accomplishment showcases our ability to collaborate seamlessly as a team and manage a complex project.

### Other Project Contributor: 
- [Connor Richmond](https://github.com/ConnorRichmond)

#### Reflection on Potential Refactor
> If we had more time, we would spend more time on testing for our NewGame class. It was difficult to test the output and user input since these occur within the terminal and not within a webpage. We would also work on decoupling more methods through single-responsibility-principles, dependency injection, and encapsulation.
---
## How To Play
- **Clone the Repository:** Begin by cloning this repository to your local machine using the following command:
`git clone git@github.com:westonio/battle_ship.git`

- **Navigate to Project Directory:** Move into the project directory:
`cd battle_ship`

- **Run the Game:** Launch the game by running the following command:
`ruby runner.rb`

- **Follow Instructions:** Within the terminal, the game will prompt you to provide the board dimensions, ship count, and ship sizes. Follow the on-screen instructions to set up your game.

- **Gameplay:** Once the game is set up, take turns with your opponent to guess each other's ship placements. The game will display the current state of the board and inform you if a ship has been hit or sunk. 👾
  
- **Winning the Game:** The player who sinks all of their opponent's ships first is declared the winner. 🎉

### Terminal Gameplay Photos:
#### Setup <br/>
<img width="623" alt="Screenshot 2023-08-20 at 12 04 28 PM" src="https://github.com/westonio/battle_ship/assets/117330008/35218125-daec-43b3-b17b-705ae863d563">
<br/><br/>

#### Game Over <br/>
<img width="453" alt="Screenshot 2023-08-20 at 12 06 53 PM" src="https://github.com/westonio/battle_ship/assets/117330008/c343e9de-fa1d-4460-91ec-1113cd76a9da">


