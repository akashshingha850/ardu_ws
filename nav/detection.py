import cv2
import numpy as np
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
from ultralytics import YOLO

# Load the YOLO model
MODEL_PATH = '/home/ubuntu/ardu_ws/nav/intesect_yolo11s.pt'
model = YOLO(MODEL_PATH)

class ImageDetectionNode(Node):
    def __init__(self):
        super().__init__('image_detection_node')
        self.bridge = CvBridge()
        self.subscription = self.create_subscription(
            Image,
            '/camera/image',
            self.image_callback,
            10
        )
        self.publisher = self.create_publisher(Image, '/camera/detected_image', 10)

    def image_callback(self, msg):
        try:
            self.get_logger().info(f'Image resolution: {msg.width}x{msg.height}')
            # Convert ROS image to OpenCV
            cv_image = self.bridge.imgmsg_to_cv2(msg, 'bgr8')
            
            # Run YOLO detection
            results = model(cv_image)
            detected_image = results[0].plot()
            
            # Convert back to ROS image and publish
            detected_msg = self.bridge.cv2_to_imgmsg(detected_image, 'bgr8')
            self.publisher.publish(detected_msg)
            
            self.get_logger().info('Published detected image')
        except Exception as e:
            self.get_logger().error('Error processing image: {}'.format(e))

def main(args=None):
    rclpy.init(args=args)
    node = ImageDetectionNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()