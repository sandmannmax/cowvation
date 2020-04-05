import React, { Component } from 'react';
import { StyleSheet, Text, View, TextInput, TouchableOpacity} from 'react-native';

export default class LoginForm extends Component {

  passwortInput;

  constructor(props) {
    super(props);
    this.state = {
      name: '',
      passwort: '',
      error: '',
    }
    this.handleName = this.handleName.bind(this);
    this.handlePasswort = this.handlePasswort.bind(this);
  }

  handleName = (event) => {
    this.setState({name: event.target.value});
  }

  handlePasswort = (event) => {
    this.setState({passwort: event.target.value});
  }

  login = () => {
    this.setState({error: ''});
    if(!this.state.name || !this.state.passwort) {
      this.setState({error: 'Sie müssen einen Namen und ein Passwort eingeben.'});
      return;
    }
    fetch('http://18.184.103.127/token/', {
      method: 'POST',
      headers : {
        Accept: 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        username: this.state.name,
        password: this.state.passwort,
      }),
    }).then((response) => {
      if(response.status == 200) {
        response.json().then(data => {
          this.props.navigation.navigate('Liste', {access: data.access, refresh: data.refresh});
        });
      } else if(response.status == 401) {
        this.setState({error: 'Der Name oder das Passwort sind ungültig.'})
      } else {
        this.setState({error: 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es demnächst erneut.'})
      }
    }).catch((error) => {
      this.setState({error: error.message});
    })
  }

  render() {
    return (
      <View style={styles.container}>
        <TextInput 
          style={styles.input}
          placeholder={'benutzername'}
          placeholderTextColor='rgba(255,255,255,0.6)'
          value={this.state.name}
          onChangeText={text => this.setState({name: text})}
          returnKeyType='next'
          onSubmitEditing={() => this.passwortInput.focus()}
          keyboardType={'email-address'}
          autoCapitalize='none'
          autoCorrect={false}
        />
        <TextInput
          style={styles.input}
          placeholder={'passwort'}
          placeholderTextColor='rgba(255,255,255,0.6)'
          value={this.state.passwort}
          onChangeText={text => this.setState({passwort: text})}
          secureTextEntry={true}
          returnKeyType='go'
          ref={(input) => this.passwortInput = input}
        />
        <TouchableOpacity style={styles.btn} onPress={this.login}>
            <Text style={styles.btnText}>LOGIN</Text>
        </TouchableOpacity>
        <Text
          style={styles.error}
        >
          {this.state.error}
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  input: {
    backgroundColor: '#80d4ff', 
    color: '#fff',   
    width: 350,
    marginBottom: 10,
    paddingTop: 5,
    paddingBottom: 5,
    textAlign: 'center',
  },
  btn: {
    backgroundColor: '#134363',
    width: 350,
  },
  btnText: {
    marginTop: 10,
    marginBottom: 10,
    textAlign: 'center',
    color: '#fff',
    fontWeight: 'bold',
  },
  error: {
    color: '#b30000', 
    textAlign: 'center',
    marginTop: 10,
  },
});
