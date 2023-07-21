const canvas = document.getElementById('matrixCanvas');
const ctx = canvas.getContext('2d');

function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
}

resizeCanvas();
window.addEventListener('resize', resizeCanvas);

canvas.height = window.innerHeight;
canvas.width = window.innerWidth;

const latinCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[{]}\\|;:\'",<.>/?`~';
const katakanaCharacters = Array.from({ length: 96 }, (_, i) => String.fromCharCode(0x30A0 + i)).join('');
const characters = latinCharacters + katakanaCharacters;

const fontSize = 12;
const minSpacing = 1;
const maxSpacing = 4;

function createDrops() {
    const drops = [];
    let x = 0;

    while (x < canvas.width) {
        const spacing = Math.floor(Math.random() * (maxSpacing - minSpacing + 1) + minSpacing);
        const size = Math.random() * 1.5 + 0.5; // Random size between 0.5 and 2
        const redRaindropProbability = Math.random();
        const color = redRaindropProbability < 0.005 ? 'red' : 'green';
        drops.push({x: x, y: 1, size: size, color: color});
        x += fontSize * spacing;
    }

    return drops;
}

let drops = createDrops();

function drawMatrix() {
    ctx.fillStyle = 'rgba(0, 0, 0, 0.1)';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    ctx.font = fontSize + 'px monospace';

    for (let i = 0; i < drops.length; i++) {
        const text = characters[Math.floor(Math.random() * characters.length)];
        const scaledFontSize = fontSize * drops[i].size;

        // Bottom character is always white
        ctx.fillStyle = '#FFF';
        ctx.font = scaledFontSize + 'px monospace';
        ctx.fillText(text, drops[i].x, drops[i].y * scaledFontSize);

        // Trailing characters
        for (let j = 1; j <= 10; j++) {
            const trailText = characters[Math.floor(Math.random() * characters.length)];

            // Set color for trailing characters based on the drop's color
            ctx.fillStyle = drops[i].color === 'red' ? '#F00' : '#0f0';

            ctx.fillText(trailText, drops[i].x, (drops[i].y - j) * scaledFontSize);
        }

        if (drops[i].y * scaledFontSize > canvas.height || Math.random() > 0.975) {
            drops[i].y = 0;
            let newX = drops[i].x;
            while (Math.abs(newX - drops[i].x) < minSpacing * fontSize) {
                newX = Math.floor(Math.random() * (canvas.width / fontSize)) * fontSize;
            }
            drops[i].x = newX;

            // Assign color for new drop
            const redRaindropProbability = Math.random();
            drops[i].color = redRaindropProbability < 0.005 ? 'red' : 'green';
        }

        drops[i].y += drops[i].size; // Bigger raindrops fall faster
    }
}

setInterval(drawMatrix, 100); // Decrease the time between spawning new raindrops
