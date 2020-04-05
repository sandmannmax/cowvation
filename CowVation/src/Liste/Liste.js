import React, { Component } from 'react';
import { StyleSheet, Text, View, FlatList, TouchableOpacity, RefreshControl } from 'react-native';
import ListeItem from './ListeItem'

export default class Liste extends Component {
  constructor(props) {
    super(props);
    this.state = {
      access: this.props.navigation.getParam('access'),
      refresh: this.props.navigation.getParam('refresh'),
      error: '',
      data: [],
      canLoad: true,
      len: 0,
      refreshing: false,
    }
  }

  static navigationOptions = {
    header: () => false,
  }

  load = () => {
    if(this.state.canLoad){
      fetch('http://18.184.103.127/api/cow/', {
        method: 'GET',
        headers : {
          //'Authorization': 'Bearer ' + this.state.access,
          'Authorization': 'Bearer ' + this.state.access,
          'Content-Type': 'application/json',
        }
      }).then((response) => {
        if(response.status == 200) {
          response.json().then(data => {
            this.setState({data: []})
            data.forEach(obj => {
              this.state.data.push({nummer: obj.nummer, ohrmarke: obj.ohrmarke, rasse: obj.rasse, navigation:  this.props.navigation, access: this.state.access, refresh: this.state.refresh});
            });
          });
        } else if(response.status == 401) {
          fetch('http://18.184.103.127/token/refresh/', {
            method: 'POST',
            headers : {
              Accept: 'application/json',
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              refresh: this.state.refresh,
            }),
          }).then((response) => {
            if(response.status == 200) {
              response.json().then(data => {
                this.setState({access: data.access});
              });
              this.load();
            } else {
              this.setState({error: 'Ein Fehler ist aufgetreten. Bitte App neustarten.', canLoad: false});
            }
          }).catch((error) => {
            this.setState({error: error.message});
          })
        } else {
          this.setState({error: 'Es ist ein Fehler aufgetreten. Bitte versuchen Sie es demnächst erneut.'})
        }
      }).catch((error) => {
        this.setState({error: error.message});
      });
    }
  }

  cowAdd = () => {
    this.props.navigation.navigate('CowAdd', {access: this.state.access, refresh: this.state.refresh});
  }

  componentDidMount(){
    this.load();
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.topBar}>
          <View style={styles.containerRow}>
            <View style={styles.containerNummer}>
              <Text style={styles.text}>Nummer</Text>
            </View>
            <View style={styles.containerOhrmarke}>
              <Text style={styles.text}>Ohrmarke</Text>
            </View>
            <View style={styles.containerRasse}>
              <Text style={styles.text}>Rasse</Text>
            </View>
          </View>
        </View>
        <View style={styles.containerList}>
          <FlatList
          data={this.state.data}
          renderItem={({ item }) => <ListeItem nummer={item.nummer} ohrmarke={item.ohrmarke} rasse={item.rasse} navigation={item.navigation} access={item.access} refresh={item.refresh}/>}
          keyExtractor={item => item.nummer.toString()} refreshControl={<RefreshControl refreshing={this.state.refreshing} onRefresh={this.load} />}
          />      
        </View>
        <TouchableOpacity style={styles.addBtn} onPress={this.cowAdd}><Text style={{textAlign: 'center', fontSize: 30}}>+</Text></TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ddd',
  },
  topBar: {
    flex:1,
    flexDirection: 'row',
    backgroundColor: '#f2f2f2',
  },
  containerList: {
    flex: 15,
  },
  logoContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    fontSize: 25,
    color: '#fff',
  },
  containerRow: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
    borderBottomColor: 'rgba(255,255,255,0.2)',
    borderBottomWidth: 2,
  },
  containerNummer: {
    flex: 3,
    justifyContent: 'center',
  },
  containerOhrmarke: {
    flex: 6,
    justifyContent: 'center',
    borderLeftColor: '#222',
    borderLeftWidth: 2,
    borderRightColor: '#222',
    borderRightWidth: 2,
  },
  containerRasse: {
    flex: 2,
    justifyContent: 'center',
  },
  text: {
    fontSize: 18,
    marginLeft: 10,
    marginVertical: 3,
  },
  loading: {
    justifyContent: 'center',
  },
  addBtn: {
    position: 'absolute',
    left: '43%',
    top: '88%',
    width: '14%',
    aspectRatio: 1,
    backgroundColor: '#fff',
    borderRadius: 2000,
    justifyContent: 'center',
  }
});
