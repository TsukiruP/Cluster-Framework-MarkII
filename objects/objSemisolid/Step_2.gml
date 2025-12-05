/// @description Offset
if (active)
{
    if (offset < 256) offset += 16;
}
else if (offset != 0)
{
    offset -= 16;
}