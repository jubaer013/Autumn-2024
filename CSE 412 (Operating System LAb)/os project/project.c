#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAX_INPUT_SIZE 1024
#define MAX_ARG_SIZE 100

void parseInput(char *input, char **args) {
for (int i = 0; i < MAX_ARG_SIZE; i++) {
args[i] = strsep(&input, " ");
if (args[i] == NULL) break;
if (strlen(args[i]) == 0) i--; // Remove empty arguments
}
}

void executeCommand(char **args) {
if (strcmp(args[0], "cd") == 0) {
// Handle 'cd' command
if (args[1] == NULL) {
fprintf(stderr, "cd: expected argument\n");
} else {
if (chdir(args[1]) != 0) {
perror("cd");
}
}
} else {
// Handle other commands
pid_t pid = fork();

if (pid < 0) {
perror("Fork failed");
} else if (pid == 0) {
// Child process
if (execvp(args[0], args) == -1) {
perror("Error executing command");
}
exit(EXIT_FAILURE);
} else {
// Parent process
wait(NULL);
}
}
}

int main() {
char input[MAX_INPUT_SIZE];
char *args[MAX_ARG_SIZE];

while (1) {
printf("simple-shell> ");
fgets(input, MAX_INPUT_SIZE, stdin);

// Remove newline character
input[strcspn(input, "\n")] = '\0';

// Exit condition
if (strcmp(input, "exit") == 0) break;

// Parse and execute input
parseInput(input, args);
if (args[0] != NULL) {
executeCommand(args);
}
}

return 0;
}