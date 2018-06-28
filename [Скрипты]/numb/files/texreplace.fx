texture gTexture;
texture Tex1;

//-- Very simple technique
technique simple
{
    pass P0
    {
        //-- Set up texture stage 0
        Texture[0] = gTexture;
        LightEnable[0] = TRUE;
        LightType[0] = POINT;
    }
}