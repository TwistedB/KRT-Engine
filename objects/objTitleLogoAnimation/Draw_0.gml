for (var i = 0; i < 12; i++) {
    var pos = positions[i];

    var path = (i - offset + 12) mod 12;

    var current = floor(path);
    var next = (current + 1) mod 12;
    var progress = path - current;

    var pos1 = positions[current];
    var pos2 = positions[next];

    var drawX = lerp(pos1[0], pos2[0], progress);
    var drawY = lerp(pos1[1], pos2[1], progress);

    draw_sprite_ext(sprite_index, i, x + drawX * spacing, y + drawY * spacing, 2, 2, 0, c_white, 1);
}

draw_sprite_ext(sprTitleLogoA,0, x + spacing * 1.5 - 15, y + spacing * 1.5 - 16, 2, 2, 0, c_white, 1);