uniform vec2 window_dimensions;

layout(location = 0) in vec3 left_top;
layout(location = 1) in vec2 right_bottom;
layout(location = 2) in vec2 tex_left_top;
layout(location = 3) in vec2 tex_right_bottom;
layout(location = 4) in vec4 color;

out vec2 f_tex_pos;
out vec4 f_color;

// generate positional data based on vertex ID
void main() {
    mat4 transform = mat4(
        vec4(2.0 / window_dimensions.x, 0.0, 0.0, 0.0),
        vec4(0.0, -2.0 / window_dimensions.y, 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(-1.0, 1.0, 0.0, 1.0)
    );
    vec2 pos = vec2(0.0);
    float left = left_top.x;
    float right = right_bottom.x;
    float top = left_top.y;
    float bottom = right_bottom.y;

    switch (gl_VertexID) {
        case 0:
            pos = vec2(left, top);
            f_tex_pos = tex_left_top;
            break;

        case 1:
            pos = vec2(right, top);
            f_tex_pos = vec2(tex_right_bottom.x, tex_left_top.y);
            break;

        case 2:
            pos = vec2(left, bottom);
            f_tex_pos = vec2(tex_left_top.x, tex_right_bottom.y);
            break;

        case 3:
            pos = vec2(right, bottom);
            f_tex_pos = tex_right_bottom;
            break;
    }

    f_color = color;
    gl_Position = transform * vec4(pos, left_top.z, 1.0);
}