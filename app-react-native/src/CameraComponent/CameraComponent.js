import React, { Component } from 'react';
import { StyleSheet, View, TouchableOpacity } from 'react-native';
import { RNCamera } from 'react-native-camera';

export default class CameraComponent extends Component {
    camera;

    static navigationOptions = {
        header: () => false,
    }

    takePicture = async () => {
        if(this.camera) {
            this.camera.takePictureAsync({quality: 0.5, base64: true}).then(photo => {
                this.camera.pausePreview();
                this.props.navigation.state.params.goBackData({photo});
                this.props.navigation.pop();
            }).catch(error => {
                console.warn(error);
            });
        }
    }

    render() {
        return (
            <View style={{flex: 1}}>
                <RNCamera ref={ref => {this.camera = ref}} style={{ flex: 1 }} type={RNCamera.Constants.Type.back} captureAudio={false}
                    androidCameraPermissionOptions={{
                        title: 'Berechtigung zur Kameranutzung',
                        message: 'Wir brauchen deine Zustimmung um die Kamera nutzen zu können',
                        buttonPositive: 'Ok',
                        buttonNegative: 'Abbrechen',
                }}>
                    <View style={styles.btnContainer}>
                        <TouchableOpacity style={styles.btn} onPress={this.takePicture}>
                            <View style={styles.btnView}/>
                        </TouchableOpacity>
                    </View>
                </RNCamera>
            </View>
        );
    }
}

const styles = StyleSheet.create({
  container: {
      paddingTop: 24,
  },
  btnContainer: {
    flex: 1,
    backgroundColor: 'transparent',
    flexDirection: 'row',
    justifyContent: 'center',
    marginBottom: 20,
  },
  btn: {
    flex: 0.1,
    alignSelf: 'flex-end',
    alignItems: 'center',
  },
  btnView: {
    backgroundColor: 'transparent',
    borderRadius: 50,
    borderWidth: 4,
    borderColor: '#fff',
    height: 40,
    aspectRatio: 1,
  },
});
