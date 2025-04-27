$(document).ready(function () {
    // Form validation
    $('form').submit(function (event) {
        let valid = true;
        const titleLength = $('#title').val().length;
        const authorLength = $('#author').val().length;
        const passwordLength = $('#password').val().length;
        const contentLength = $('#content').val().length;

        // Clear previous error messages
        $('.error-message').remove();

        // Validate title (max 100 char)
        if (titleLength === 0 || titleLength > 100) {
            $('#title').after('<div class="error-message text-danger">Title is required and must be less than 100 characters.</div>');
            valid = false;
        }

        // Validate author (max 10 char)
        if (authorLength === 0 || authorLength > 10) {
            $('#author').after('<div class="error-message text-danger">Author name is required and must be less than 10 characters.</div>');
            valid = false;
        }

        // Validate password (min 4 char)
        if (passwordLength < 4) {
            $('#password').after('<div class="error-message text-danger">Password must be at least 4 characters.</div>');
            valid = false;
        }

        // Validate content (not empty)
        if (contentLength === 0) {
            $('#content').after('<div class="error-message text-danger">Content is required.</div>');
            valid = false;
        }

        if (!valid) {
            event.preventDefault();
        }
    });
});