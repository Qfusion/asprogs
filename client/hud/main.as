namespace CGame {

namespace HUD {

ShaderHandle shaderBubble1a;
ShaderHandle shaderArrowDown;

void Init() {
	shaderBubble1a = CGame::RegisterShader( "gfx/2d/bubble1a");
	shaderArrowDown = CGame::RegisterShader( "gfx/2d/arrow_down");
}

bool DrawCrosshair() {
  auto @ps = CGame::PredictedPlayerState;
  auto @fd = GS::FiredefForPlayerState( ps, ps.stats[STAT_WEAPON] );

  auto headOrg = ps.pmove.origin + Vec3( 0.0f, 0.0f, ps.viewHeight );
  Vec3 f, r, u;
  ps.viewAngles.angleVectors( f, r, u );
  auto aimTarg = headOrg + float( fd.timeout ) * f;

  Trace tr;
  if( tr.doTrace( headOrg, vec3Origin, vec3Origin, aimTarg, ps.POVnum, MASK_SHOT ) ) {
    aimTarg = tr.endPos;
  }

  auto @cam = CGame::Camera::GetMainCamera();
  auto scrCoords = cam.refdef.transformToScreen( aimTarg );
  if( scrCoords.y < 0.0f ) {
  	CGame::DrawPic( int( scrCoords.x ) - 8, 0, 16, 16, shaderArrowDown, 1.0f, 1.0f, 0.0f, 0.0f ); 
  } else {
  	CGame::DrawPic( int( scrCoords.x ) - 16, int( scrCoords.y ) - 16, 32, 32, shaderBubble1a, 1.0f, 1.0f, 0.0f, 0.0f ); 
  }
  return true;
}

}

}
