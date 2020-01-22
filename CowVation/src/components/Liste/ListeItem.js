import React, { Component } from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';

export default class ListeItem extends Component {
  constructor(props) {
    super(props);
  }

  onSelect = () => {
    this.props.navigation.navigate('Cow', {nummer: this.props.nummer, access: this.props.access, refresh: this.props.refresh});
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity style={styles.containerRow} onPress={() => this.onSelect()}>
          <View style={styles.containerNummer}>
            <Text style={styles.text}>{this.props.nummer}</Text>
          </View>
          <View style={styles.containerOhrmarke}>
            <Text style={styles.text}>{[('0'.repeat(5 - this.props.ohrmarke.toString().length) + this.props.ohrmarke.toString()).slice(0, 2), ' ', ('0'.repeat(5 - this.props.ohrmarke.toString().length) + this.props.ohrmarke.toString()).slice(2)].join('')}</Text>
          </View>
          <View style={styles.containerRasse}>
            <Text style={styles.text}>{this.props.rasse}</Text>
          </View>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: { 
    borderBottomColor: 'rgba(255,255,255,0.4)',
    borderBottomWidth: 2,
  },
  containerRow: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  containerNummer: {
    flex: 3,
  },
  containerOhrmarke: {
    flex: 6,
  },
  containerRasse: {
    flex: 2,
  },
  text: {
    fontSize: 25,
    marginLeft: 10,
    marginVertical: 5,
  }
});
