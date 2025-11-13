// Messages Page - Tab Switching and Messaging Functionality
(function() {
    'use strict';

    // Initialize when DOM is loaded
    document.addEventListener('DOMContentLoaded', function() {
        initMessageTabs();
        initConversationItems();
        initSendMessage();
        initChatMenu();
        initMobileSidebar();
        checkForNewConversation(); // Check if coming from schedule page
    });

    // Filter Switching
    function initMessageTabs() {
        const filterButtons = document.querySelectorAll('.filter-btn');
        const conversationItems = document.querySelectorAll('.conversation-item');

        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Remove active class from all buttons
                filterButtons.forEach(btn => btn.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');

                // Get the filter type
                const filterType = this.getAttribute('data-filter');

                // Filter conversations based on selected filter
                conversationItems.forEach(item => {
                    const categories = item.getAttribute('data-category');
                    
                    if (categories && categories.includes(filterType)) {
                        item.style.display = 'flex';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });
    }

    // Conversation Item Click
    function initConversationItems() {
        const conversationItems = document.querySelectorAll('.conversation-item');

        conversationItems.forEach(item => {
            item.addEventListener('click', function() {
                // Remove active class from all items
                conversationItems.forEach(i => i.classList.remove('active'));
                
                // Add active class to clicked item
                this.classList.add('active');

                // Get user info
                const userName = this.getAttribute('data-user');
                const userTime = this.getAttribute('data-time');

                // Update chat header (optional - could load different conversation)
                updateChatHeader(userName);

                // Scroll to bottom of messages
                scrollToBottom();
            });
        });
    }

    // Update Chat Header
    function updateChatHeader(userName) {
        const chatUserName = document.querySelector('.chat-user-details h3');
        if (chatUserName) {
            chatUserName.textContent = userName;
        }

        // Get initials for avatar
        const initials = userName.split(' ').map(n => n[0]).join('');
        const chatAvatar = document.querySelector('.chat-avatar');
        if (chatAvatar) {
            chatAvatar.textContent = initials;
        }
    }

    // Send Message
    function initSendMessage() {
        const sendButton = document.getElementById('sendButton');
        const messageInput = document.getElementById('messageInput');

        if (sendButton && messageInput) {
            sendButton.addEventListener('click', sendMessage);
            
            messageInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();
                    sendMessage();
                }
            });
        }
    }

    function sendMessage() {
        const messageInput = document.getElementById('messageInput');
        const chatMessages = document.getElementById('chatMessages');

        if (!messageInput || !chatMessages) return;

        const messageText = messageInput.value.trim();
        
        if (messageText === '') return;

        // Create message element
        const messageWrapper = document.createElement('div');
        messageWrapper.className = 'message-wrapper sent';

        const currentTime = new Date().toLocaleTimeString('en-US', { 
            hour: 'numeric', 
            minute: '2-digit',
            hour12: true 
        });

        messageWrapper.innerHTML = `
            <div class="message-bubble">
                <p>${escapeHtml(messageText)}</p>
                <span class="message-time">${currentTime} <i class="fa-solid fa-check-double"></i></span>
            </div>
        `;

        // Append to chat
        chatMessages.appendChild(messageWrapper);

        // Clear input
        messageInput.value = '';

        // Scroll to bottom
        scrollToBottom();
    }

    // Escape HTML to prevent XSS
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Scroll to Bottom
    function scrollToBottom() {
        const chatMessages = document.getElementById('chatMessages');
        if (chatMessages) {
            setTimeout(() => {
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }, 100);
        }
    }

    // Chat Menu Button
    function initChatMenu() {
        const chatMenuBtn = document.getElementById('chatMenuBtn');
        const chatMenuDropdown = document.getElementById('chatMenuDropdown');
        const pinBtn = document.getElementById('pinConversationBtn');
        const deleteBtn = document.getElementById('deleteConversationBtn');
        
        if (chatMenuBtn && chatMenuDropdown) {
            // Toggle dropdown
            chatMenuBtn.addEventListener('click', function(e) {
                e.stopPropagation();
                chatMenuDropdown.classList.toggle('show');
            });

            // Close dropdown when clicking outside
            document.addEventListener('click', function(e) {
                if (!chatMenuDropdown.contains(e.target) && e.target !== chatMenuBtn) {
                    chatMenuDropdown.classList.remove('show');
                }
            });

            // Pin Conversation
            if (pinBtn) {
                pinBtn.addEventListener('click', function() {
                    const chatUserName = document.querySelector('.chat-user-details h3');
                    if (chatUserName) {
                        const isPinned = this.textContent.includes('Unpin');
                        if (isPinned) {
                            this.innerHTML = '<i class="fa-solid fa-thumbtack"></i><span>Pin Conversation</span>';
                            alert('Conversation unpinned');
                        } else {
                            this.innerHTML = '<i class="fa-solid fa-thumbtack"></i><span>Unpin Conversation</span>';
                            alert('Conversation pinned to top');
                        }
                    }
                    chatMenuDropdown.classList.remove('show');
                });
            }

            // Delete Conversation
            if (deleteBtn) {
                deleteBtn.addEventListener('click', function() {
                    const chatUserName = document.querySelector('.chat-user-details h3');
                    if (chatUserName) {
                        const confirmDelete = confirm(`Are you sure you want to delete the conversation with ${chatUserName.textContent}?\n\nThis action cannot be undone.`);
                        if (confirmDelete) {
                            alert('Conversation deleted');
                            // Here you would typically call an API to delete the conversation
                        }
                    }
                    chatMenuDropdown.classList.remove('show');
                });
            }
        }
    }

    // Search Functionality
    const searchInput = document.getElementById('messageSearchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const conversationItems = document.querySelectorAll('.conversation-item');
            const activeFilter = document.querySelector('.filter-btn.active');
            const currentFilter = activeFilter ? activeFilter.getAttribute('data-filter') : 'all';

            conversationItems.forEach(item => {
                const userName = item.getAttribute('data-user').toLowerCase();
                const preview = item.querySelector('.conversation-preview').textContent.toLowerCase();
                const categories = item.getAttribute('data-category');

                // Check if item matches search term
                const matchesSearch = userName.includes(searchTerm) || preview.includes(searchTerm);
                
                // Check if item matches current filter
                const matchesFilter = categories && categories.includes(currentFilter);

                // Show item only if it matches both search and filter
                if (matchesSearch && matchesFilter) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    }

    // Mobile Sidebar Toggle
    function initMobileSidebar() {
        const mobileContactsBtn = document.getElementById('mobileContactsBtn');
        const mobileCloseBtn = document.getElementById('mobileCloseSidebarBtn');
        const messagesSidebar = document.querySelector('.messages-sidebar');

        // Open sidebar when contact button is clicked
        if (mobileContactsBtn) {
            mobileContactsBtn.addEventListener('click', function() {
                if (messagesSidebar) {
                    messagesSidebar.classList.add('mobile-show');
                }
            });
        }

        // Close sidebar when close button is clicked
        if (mobileCloseBtn) {
            mobileCloseBtn.addEventListener('click', function() {
                if (messagesSidebar) {
                    messagesSidebar.classList.remove('mobile-show');
                }
            });
        }

        // Close sidebar when a conversation is selected (mobile only)
        const conversationItems = document.querySelectorAll('.conversation-item');
        conversationItems.forEach(item => {
            item.addEventListener('click', function() {
                // Check if we're on mobile (window width <= 768px)
                if (window.innerWidth <= 768 && messagesSidebar) {
                    messagesSidebar.classList.remove('mobile-show');
                }
            });
        });
    }

    // Check for New Conversation from Schedule Page
    function checkForNewConversation() {
        const passengerData = sessionStorage.getItem('contactPassenger');
        
        if (passengerData) {
            try {
                const passenger = JSON.parse(passengerData);
                
                // Check if conversation already exists
                const conversationList = document.getElementById('conversationList');
                if (!conversationList) return;
                
                const existingConversation = Array.from(conversationList.querySelectorAll('.conversation-item'))
                    .find(item => item.getAttribute('data-user') === passenger.name);
                
                if (existingConversation) {
                    // If conversation exists, just activate it
                    activateConversation(existingConversation, passenger.name);
                } else {
                    // Create new conversation
                    createNewConversation(passenger);
                }
                
                // Clear the session storage
                sessionStorage.removeItem('contactPassenger');
                
            } catch (e) {
                console.error('Error parsing passenger data:', e);
                sessionStorage.removeItem('contactPassenger');
            }
        }
    }

    // Create New Conversation
    function createNewConversation(passenger) {
        const conversationList = document.getElementById('conversationList');
        if (!conversationList) return;
        
        // Get initials for avatar
        const initials = passenger.name.split(' ').map(n => n[0]).join('');
        
        // Generate random color for avatar
        const colors = ['#4285F4', '#34A853', '#FBBC04', '#EA4335', '#9C27B0', '#FF5722', '#009688', '#795548'];
        const randomColor = colors[Math.floor(Math.random() * colors.length)];
        
        // Get current time
        const currentTime = new Date().toLocaleTimeString('en-US', { 
            hour: 'numeric', 
            minute: '2-digit',
            hour12: false
        });
        
        // Create new conversation item
        const conversationItem = document.createElement('div');
        conversationItem.className = 'conversation-item active';
        conversationItem.setAttribute('data-user', passenger.name);
        conversationItem.setAttribute('data-time', currentTime);
        conversationItem.setAttribute('data-category', 'all inbox');
        
        conversationItem.innerHTML = `
            <div class="conversation-avatar" style="background-color: ${randomColor};">
                <span style="color: #ffffff;">${initials}</span>
                <span class="online-indicator"></span>
            </div>
            <div class="conversation-info">
                <div class="conversation-header">
                    <span class="conversation-name">${passenger.name}</span>
                    <span class="conversation-time">${currentTime}</span>
                </div>
                <div class="conversation-preview">Booking ID: ${passenger.bookingId} - ${passenger.phone}</div>
            </div>
        `;
        
        // Remove active class from all existing conversations
        conversationList.querySelectorAll('.conversation-item').forEach(item => {
            item.classList.remove('active');
        });
        
        // Insert at the top of the list
        conversationList.insertBefore(conversationItem, conversationList.firstChild);
        
        // Add click event listener to new conversation
        conversationItem.addEventListener('click', function() {
            conversationList.querySelectorAll('.conversation-item').forEach(i => i.classList.remove('active'));
            this.classList.add('active');
            updateChatHeader(passenger.name);
            scrollToBottom();
        });
        
        // Update chat header with new conversation
        updateChatHeader(passenger.name);
        
        // Add initial message to chat
        addInitialMessage(passenger);
        
        // Scroll to bottom
        scrollToBottom();
    }

    // Activate Existing Conversation
    function activateConversation(conversationItem, userName) {
        const conversationList = document.getElementById('conversationList');
        
        // Remove active class from all conversations
        conversationList.querySelectorAll('.conversation-item').forEach(item => {
            item.classList.remove('active');
        });
        
        // Add active class to the conversation
        conversationItem.classList.add('active');
        
        // Move conversation to top
        conversationList.insertBefore(conversationItem, conversationList.firstChild);
        
        // Update chat header
        updateChatHeader(userName);
        
        // Scroll to bottom
        scrollToBottom();
    }

    // Add Initial Message to Chat
    function addInitialMessage(passenger) {
        const chatMessages = document.getElementById('chatMessages');
        if (!chatMessages) return;
        
        // Clear existing messages (optional - or you could keep them)
        chatMessages.innerHTML = '';
        
        // Add system message
        const systemMessage = document.createElement('div');
        systemMessage.className = 'message-wrapper system-message';
        systemMessage.style.textAlign = 'center';
        systemMessage.style.padding = '10px';
        systemMessage.style.color = '#666';
        systemMessage.style.fontSize = '13px';
        
        const currentDate = new Date().toLocaleDateString('en-US', { 
            month: 'long', 
            day: 'numeric', 
            year: 'numeric' 
        });
        
        systemMessage.innerHTML = `
            <div style="background: #f0f0f0; padding: 8px 12px; border-radius: 12px; display: inline-block;">
                <p style="margin: 0;">Conversation started with <strong>${passenger.name}</strong></p>
                <p style="margin: 5px 0 0 0; font-size: 11px;">Booking ID: ${passenger.bookingId} • Phone: ${passenger.phone}</p>
                <p style="margin: 5px 0 0 0; font-size: 11px; color: #888;">${currentDate}</p>
            </div>
        `;
        
        chatMessages.appendChild(systemMessage);
    }

})();
