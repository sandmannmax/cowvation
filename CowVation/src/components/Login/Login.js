import React, { Component } from 'react';
import { StyleSheet, Text, View, KeyboardAvoidingView, Image } from 'react-native';
import LoginForm from './LoginForm';

export default class Login extends Component {
  constructor(props) {
    super(props);
  }

  static navigationOptions = {
    header: () => false,
  }

  render() {
    return (
      <KeyboardAvoidingView style={styles.container} behavior="padding" keyboardVerticalOffset={10}>
        <View style={styles.logoContainer}>
          <Image style={styles.logo} source={require('./../../../cowvationLogoW.png')} />
        </View>
        <View style={styles.loginContainer}>
          <LoginForm navigation={this.props.navigation}/>
        </View>
      </KeyboardAvoidingView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#3498db',
  },
  logoContainer: {
    flex: 2.5,
    alignItems: 'center',
    justifyContent: 'center',
  },
  loginContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    fontSize: 25,
    color: '#fff',
  },
  logo: {
    width: '45%',
    height: '45%',
    resizeMode: 'center',
    overflow: 'visible',
  },
});
