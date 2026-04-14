#include <stdio.h>

int main() {
    char board[3][3];
    
    // Read the 3x3 board, skipping whitespace
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            scanf(" %c", &board[i][j]);  // Space before %c skips whitespace
        }
    }
    
    char winner = '\0';
    
    // Check rows
    for (int i = 0; i < 3; i++) {
        if (board[i][0] != '.' && 
            board[i][0] == board[i][1] && 
            board[i][1] == board[i][2]) {
            winner = board[i][0];
            break;
        }
    }
    
    // Check columns
    if (!winner) {
        for (int j = 0; j < 3; j++) {
            if (board[0][j] != '.' && 
                board[0][j] == board[1][j] && 
                board[1][j] == board[2][j]) {
                winner = board[0][j];
                break;
            }
        }
    }
    
    // Check diagonals
    if (!winner) {
        // Top-left to bottom-right
        if (board[0][0] != '.' && 
            board[0][0] == board[1][1] && 
            board[1][1] == board[2][2]) {
            winner = board[0][0];
        }
        // Top-right to bottom-left
        else if (board[0][2] != '.' && 
                 board[0][2] == board[1][1] && 
                 board[1][1] == board[2][0]) {
            winner = board[0][2];
        }
    }
    
    // Output result
    if (winner) {
        printf("%c\n", winner);
    } else {
        printf("None\n");
    }
    
    return 0;
}