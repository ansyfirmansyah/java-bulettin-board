// src/main/webapp/resources/js/api-client.js
const API_BASE_URL = '/api';

const apiClient = {
    // Get all posts
    getAllPosts: async () => {
        try {
            const response = await fetch(`${API_BASE_URL}/posts`);
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error fetching posts:', error);
            throw error;
        }
    },

    // Get a single post by ID
    getPostById: async (id) => {
        try {
            const response = await fetch(`${API_BASE_URL}/posts/${id}`);
            const data = await response.json();
            return data;
        } catch (error) {
            console.error(`Error fetching post ${id}:`, error);
            throw error;
        }
    },

    // Create a new post
    createPost: async (postData) => {
        try {
            const response = await fetch(`${API_BASE_URL}/posts`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(postData)
            });
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Error creating post:', error);
            throw error;
        }
    },

    // Update an existing post
    updatePost: async (id, postData) => {
        try {
            const response = await fetch(`${API_BASE_URL}/posts/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(postData)
            });
            const data = await response.json();
            return data;
        } catch (error) {
            console.error(`Error updating post ${id}:`, error);
            throw error;
        }
    },

    // Delete a post
    deletePost: async (id, password) => {
        try {
            const response = await fetch(`${API_BASE_URL}/posts/${id}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({password})
            });
            const data = await response.json();
            return data;
        } catch (error) {
            console.error(`Error deleting post ${id}:`, error);
            throw error;
        }
    },

    // Verify password for a post
    verifyPassword: async (id, password) => {
        try {
            const response = await fetch(`${API_BASE_URL}/posts/${id}/verify-password`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({password})
            });
            const data = await response.json();
            return data;
        } catch (error) {
            console.error(`Error verifying password for post ${id}:`, error);
            throw error;
        }
    },

    formatDateForDisplay: function formatDateForDisplay(dateValue) {
        if (!dateValue) return '';

        try {
            // Handle array format [year, month, day, hour, minute, second, nano]
            if (Array.isArray(dateValue)) {
                const date = new Date(
                    dateValue[0],        // year
                    dateValue[1] - 1,    // month (0-based in JS)
                    dateValue[2],        // day
                    dateValue[3],        // hour
                    dateValue[4],        // minute
                    dateValue[5]         // second
                );
                return date.toLocaleString();
            }

            // Handle string format
            return new Date(dateValue).toLocaleString();
        } catch (e) {
            console.error("Error formatting date:", e);
            return String(dateValue);
        }
    }
};