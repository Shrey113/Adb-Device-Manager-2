// ================================================
// ADB Device Manager - Interaction Controller
// Handles navigation and user interactions
// ================================================

// User selection storage
const userSelection = {
    platform: null,
    setupType: null
};

// Platform selection handler (Page 1)
function selectPlatform(platform) {
    userSelection.platform = platform;
    userSelection.setupType = null; // Reset setup type
    saveSelection();
    
    // Navigate to setup type selection
    setTimeout(() => {
        window.location.href = 'android-connection-selection.html';
    }, 150);
}

// Setup type selection handler (Page 2)
function selectSetup(setupType) {
    userSelection.setupType = setupType;
    saveSelection();
    
    // Navigate based on platform
    setTimeout(() => {
        if (userSelection.platform === 'windows') {
            window.location.href = 'Full-setup.html';
        } else if (userSelection.platform === 'linux') {
            // Placeholder for Linux guide
            alert('Linux setup guide coming soon!');
        } else {
            // Fallback
            console.log('Setup complete:', userSelection);
        }
    }, 150);
}

// Back navigation handler
function goBack() {
    window.history.back();
}

// Save selection to localStorage
function saveSelection() {
    try {
        localStorage.setItem('adb-device-manager-selection', JSON.stringify(userSelection));
    } catch (e) {
        console.error('Failed to save selection:', e);
    }
}

// Load selection from localStorage
function loadSelection() {
    try {
        const saved = localStorage.getItem('adb-device-manager-selection');
        if (saved) {
            const parsed = JSON.parse(saved);
            userSelection.platform = parsed.platform || null;
            userSelection.setupType = parsed.setupType || null;
        }
    } catch (e) {
        console.error('Failed to load selection:', e);
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
    loadSelection();
    
    // Add keyboard navigation
    document.addEventListener('keydown', (e) => {
        // ESC to go back
        if (e.key === 'Escape') {
            if (window.location.pathname.includes('android-connection-selection')) {
                window.history.back();
            }
        }
        
        // Number keys for quick selection (Page 1)
        if (window.location.pathname.includes('device-platform-selection')) {
            if (e.key === '1') selectPlatform('windows');
            if (e.key === '2') selectPlatform('linux');
            // macOS (key 3) is disabled - coming soon
        }
        
        // Number keys for quick selection (Page 2)
        if (window.location.pathname.includes('android-connection-selection')) {
            if (e.key === '1') selectSetup('adb');
            if (e.key === '2') selectSetup('app-only');
        }
    });
    
    // Add keyboard focus support
    const cards = document.querySelectorAll('.platform-card, .setup-card');
    cards.forEach((card, index) => {
        card.setAttribute('tabindex', '0');
        card.setAttribute('role', 'button');
        
        card.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                card.click();
            }
        });
    });
});
