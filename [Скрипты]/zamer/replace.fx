texture gTexture;

//-- Very simple technique
technique simple
{
    pass P0
    {
        //-- Set up texture stage 0
        Texture[0] = gTexture;
	}
}