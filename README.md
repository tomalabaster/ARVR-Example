# Room-Scale-VR-Demo
A basic 6-DoF VR example using ARKit for tracking.

## How it works
By using ARKit for tracking, we can simply remove the camera feed from the ARSCNView, add in a second ARSCNView which mirrors the first then just offset the mirrored one's point of view in order to create the stereoscopic 3D effect.
